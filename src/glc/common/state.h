/**
 * \file glc/common/state.h
 * \brief glc state interface adapted from original work (glc) from Pyry Haulos <pyry.haulos@gmail.com>
 * \author Olivier Langlois <olivier@trillion01.com>
 * \date 2014

    Copyright 2014 Olivier Langlois

    This file is part of glcs.

    glcs is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    glcs is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with glcs.  If not, see <http://www.gnu.org/licenses/>.

 */

/**
 * \addtogroup common
 *  \{
 * \defgroup state glc state
 *  \{
 */

#ifndef _STATE_H
#define _STATE_H

#include <glc/common/glc.h>

#ifdef __cplusplus
extern "C" {
#endif

/** all stream operations should cancel */
#define GLC_STATE_CANCEL     0x1

/**
 * \brief video stream object
 */
typedef struct glc_state_video_s* glc_state_video_t;

/**
 * \brief audio stream object
 */
typedef struct glc_state_audio_s* glc_state_audio_t;

/**
 * \brief initialize state
 * \param glc glc
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_init(glc_t *glc);

/**
 * \brief destroy state
 * \param glc glc
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_destroy(glc_t *glc);

/**
 * \brief acquire a new video stream
 * \param glc glc
 * \param id returned video stream identifier
 * \param video returned video stream object
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_video_new(glc_t *glc, glc_stream_id_t *id,
				 glc_state_video_t *video);

/**
 * \brief acquire a new audio stream
 * \param glc glc
 * \param id returned audio stream identifier
 * \param audio returned audio stream object
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_audio_new(glc_t *glc, glc_stream_id_t *id,
				 glc_state_audio_t *audio);

/**
 * \brief set state flag
 * \param glc glc
 * \param flag flag to set
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_set(glc_t *glc, int flag);

/**
 * \brief clear state flag
 * \param glc glc
 * \param flag flag to clear
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_clear(glc_t *glc, int flag);

/**
 * \brief test state flag
 * \note for performance reasons this function doesn't acquire
 *       a global state mutex lock.
 * \param glc glc
 * \param flag flag to test
 * \return 1 if flag is set, otherwise 0
 */
__PUBLIC __inline__ int glc_state_test(glc_t *glc, int flag);

/**
 * \brief get state time
 *
 * State time is glc_time() minus current state time difference.
 * \note doesn't acquire a global time difference lock
 * \param glc glc
 * \return current state time
 */
__PUBLIC glc_utime_t glc_state_time(glc_t *glc);

/**
 * \brief add value to state time difference
 * \param glc glc
 * \param diff new time difference
 * \return 0 on success otherwise an error code
 */
__PUBLIC int glc_state_time_add_diff(glc_t *glc, glc_stime_t diff);

__PUBLIC void glc_state_time_reset(glc_t *glc);

#ifdef __cplusplus
}
#endif

#endif

/**  \} */
/**  \} */
